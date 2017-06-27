require 'nokogiri'

class JunitReader
  class << self
    def build_json_from_juniter(file_path)
      answer = {}
      xml = File.read(file_path)
      doc = Nokogiri::XML(xml) do |config|
        config.options = Nokogiri::XML::ParseOptions::NOBLANKS
      end

      root_element = doc.root
      answer["name"] = root_element["name"]
      answer["tests"] = root_element["tests"]
      answer["failures"] = root_element["failures"]

      testsuites = root_element.children.map do |element|
        # Read testsuite
        next if element.name != "testsuite"
        read_test_suite( element )
      end
      testsuites.compact!
      answer["testuites"] =  testsuites
      answer.compact
    end
    
    def read_test_suite(element)
      test_suite = {}
      test_suite["name"] = element["name"]
      test_suite["tests"] = element["tests"]
      test_suite["failures"] = element["failures"]
      testcases = element.children.map do |element_testcase|
        # Read testcase
        next if element_testcase.name != "testcase"
        read_test_case(element_testcase)
      end
      testcases.compact!

      test_suite["testcases"]  = testcases
      test_suite
    end

    def read_test_case(element)
      testcase = {}
      testcase["classname"] = element["classname"]
      testcase["name"] = element["name"]
      testcase["time"] = element["time"]
      failure_node = element.children.first
      if failure_node && failure_node.name == "failure"
        testcase["failure"] = {
          message: failure_node["message"],
          __content__: failure_node.text
        }
      end
      testcase
    end
  end
end
