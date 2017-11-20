require "./spec_helper"

describe Reeelog do
	first = Reeelog.start("first_test.log")
	second = Reeelog.start("second_test.log")

	it "makes ./logs folder" do
		Dir.exists?("logs").should be_true
	end

	Dir.cd("logs")

	it "makes log files" do
		File.exists?("first_test.log").should be_true
		File.exists?("second_test.log").should be_true
	end

	it "starts with date" do
		content = File.read("first_test.log")
		content.starts_with?("### app started ").should be_true
	end

	Dir.cd("..")

	it "logs every level" do
		puts "\n### will log ever level ###"
		{% for level in ["error", "fatal", "warn", "trace", "info", "success"] %}
			first.{{level.id}}("foo", "bar")
			Dir.cd("logs")
			content = File.read("first_test.log")
			string = "[#{{{level}}.upcase}] [FOO] bar\n"
			content.ends_with?(string).should be_true
			Dir.cd("..")
		{% end %}
	end

	it "doesnt save debugs" do
		puts "\n### will log debug message ###"
		first.debug("debug message")
		Dir.cd("logs")
		content = File.read("first_test.log")
		content.ends_with?("debug message").should be_false
		content.ends_with?("debug message\n").should be_false
		Dir.cd("..")
	end

	FileUtils.rm_r("logs")
end
