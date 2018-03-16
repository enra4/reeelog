require "./reeelog/*"
require "colorize"

module Reeelog
	def self.start(filename : (String | Nil) = nil)
		Main.new(filename)
	end
end

macro define_methods(filename, nofile)
	{% hash = {
		"error" => :red,
		"fatal" => :red,
		"warn" => :yellow,
		"trace" => :white,
		"info" => :blue,
		"success" => :green
	} %}
	{% for name, colour in hash %}
		def {{name.id}}(scope, msg)
			time = Time.now
			time = "#{Time.new(time.year, time.month, time.day, time.hour, time.minute, time.second)}"
			spacing = ""
			while spacing.size < (6 - scope.size)
				spacing = spacing + " "
			end

			if {{name}} == "fatal"
				puts "#{time}  #{scope.colorize({{colour}}).mode(:reverse)}#{spacing} #{msg}"
			else
				puts "#{time}  #{scope.colorize({{colour}})}#{spacing} #{msg}"
			end

			unless {{nofile}}
				# find better way to write to file than this?
				Dir.cd("logs")
				content = File.read({{filename}})
				content += "(#{time}) [#{{{name}}.upcase}] [#{scope.upcase}] #{msg}\n"
				File.write({{filename}}, content)
				Dir.cd("..")
			end
		end
	{% end %}
end

class Main
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
			Dir.cd("..")
		else
			@filename = ""
			@nofile = true
		end
	end

	# debug doesnt log to file
	def debug(msg)
		time = Time.now
		time = "#{Time.new(time.year, time.month, time.day, time.hour, time.minute, time.second)}"
		puts "#{time}  debug  #{msg}".colorize(:light_gray).mode(:reverse)
	end

	define_methods(@filename, @nofile)
end
