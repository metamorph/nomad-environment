job "environ" {
	datacenters = ["dc1"]

	group "web" {
		# Define a task to run
		task "app" {
			# Use Docker to run the task.
			driver = "java"

			config {
				jar_path = "local/environment-0.0.1-SNAPSHOT.jar"
				jvm_options = ["-Dserver.port=${NOMAD_PORT_app}"]
			}

			service {
				name = "${TASKGROUP}-app"
				port = "app"
				check {
					name = "alive"
					type = "http"
					path = "/health"
					interval = "10s"
					timeout = "2s"
				}
			}

			resources {
				network {
					mbits = 10
					port "app" { }
				}
			}

			artifact {
				source = "https://github.com/metamorph/nomad-environment/releases/download/0.1/environment-0.0.1-SNAPSHOT.jar"
			}

		}
	}
}
