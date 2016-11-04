job "environ" {
	datacenters = ["dc1"]

	group "web" {
		# Define a task to run
		task "app" {
			# Use Docker to run the task.
			driver = "java"

			config {
				jar_path = "local/environment-0.0.1-SNAPSHOT.jar"
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
				source = "./target/environment-0.0.1-SNAPSHOT.jar"
			}

		}
	}
}
