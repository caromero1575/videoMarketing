#Delayed::Job.attr_accessible :priority, :payload_object, :handler, :run_at, :failed_at
Delayed::Worker.configure do |config|
# optional params:
	config.aws_config = 'aws.yml' # Specify the file location of the AWS configuration YAML if you're not using Rails and you want to use a YAML file instead of calling AWS.config
	config.default_queue_name = 'videoMarketing' # Specify an alternative default queue name
end
