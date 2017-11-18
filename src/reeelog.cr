require "./reeelog/*"
require "chalk_box"

module Reeelog
	def self.start(use_logfile)
		return Main.new(use_logfile)
	end
end

macro define_methods(use_logfile, filename)
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

			if {{use_logfile}}
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

	@use_logfile : Bool
	@filename : String

	def initialize(use_logfile : Bool)
		@use_logfile = use_logfile
		@filename = "reeelog.log"

		if @use_logfile
			emptyline = "\n"
			unless File.exists?(@filename)
				File.write(@filename, "")
				# no emptyline if first time write to file
				emptyline = ""
			end

			content = File.read(@filename)
			content += "#{emptyline}### app started #{Time.now}\n"
			File.write(@filename, content)
		end
	end

	define_methods(@use_logfile, @filename)
end
