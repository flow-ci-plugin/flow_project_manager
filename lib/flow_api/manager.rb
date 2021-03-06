require 'api_tools'
require "json"
require_relative "../utils/junit_reader"

module FlowApi
  class Rest < DefaultRest
    class << self
      def basic_url
        ENV["FLOW_DOMAIN"] || "http://api-lyon.flow.ci"
      end

      def base_params
        {
          project_api_token: ENV["FLOW_PROJECT_API_TOKEN"]
        }
      end

      def basic_options
        @tmp ||= super.merge(other_base_execute_option: { log: Logger.new(STDOUT) })
      end

      def send_log_json(project_id, job_id, json_str)
        path = "/jobs/#{job_id}/upload_test_log_details"
        patch(path, project_id: project_id, json_str: json_str)
      end
    end
  end
  class Manager
    class << self
      def junit_file_to_hash(junit_path)
        return {} unless File.exist? junit_path
        log_xml = File.read(junit_path)
        Crack::XML.parse(log_xml)
      end

      def send_test_log_json(file_path)
        json_str = JunitReader.build_json_from_juniter(file_path).to_json
        FlowApi::Rest.send_log_json ENV["FLOW_PROJECT_ID"], ENV["FLOW_JOB_ID"], json_str
      end
    end
  end
end
