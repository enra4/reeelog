require "./reeelog/*"
require "chalk_box"

module Reeelog
	def self.start(filename : (String | Nil) = nil)
		Main.new(filename)
	end
end

macro define_methods(filename, nofile)
	{% hash = {
		"error" => "red",
		"fatal" => "bgRed",
		"warn" => "yellow",
		"trace" => "white",
		"info" => "blue",
		"success" => "green"
	} %}
	{% for name, colour in hash %}
		def {{name.id}}(scope, msg)
			time = Time.now
			time = "#{Time.new(time.year, time.month, time.day, time.hour, time.minute, time.second)}"
			puts "#{time} #{chalk.{{colour.id}}(scope)} #{msg}"

			unless {{nofile}}
				# find better way to write to file than this?
				content = File.read({{filename}})
				content += "(#{time}) [#{scope.upcase}] #{msg}\n"
				File.write({{filename}}, content)
			end
		end
	{% end %}
end

class Main
	include ChalkBox

	# only need one property
	# but unions seems to act weird on properties?
	@filename : String
	@nofile : Bool

	def initialize(filename : (String | Nil))
		unless filename.nil?
			@filename = filename
			@nofile = false

			unless Dir.exists?("logs")
				Dir.mkdir("logs")
			end

			Dir.cd("logs")
			emptyline = "\n"

			unless File.exists?(filename)
				File.write(filename, "")
				# no emptyline if first time write to file
				emptyline = ""
			end

			content = File.read(filename)
			content += "#{emptyline}### app started #{Time.now}\n"
			File.write(filename, content)
		else
			@filename = ""
			@nofile = true
		end
	end

	def debug(msg)
		time = Time.now
		time = "#{Time.new(time.year, time.month, time.day, time.hour, time.minute, time.second)}"
		puts chalk.white.bgGrey("#{time} debug #{msg}")
	end

	define_methods(@filename, @nofile)
end
