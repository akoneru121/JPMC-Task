

resource "aws_instance" "primary_instance" {
  provider          = aws.primary
  ami               = var.ami_id
  key_name          = "task"
  instance_type     = var.instance_type
  security_groups   = [aws_security_group.tomcat_sg.name]



user_data = <<-EOF
                #!/bin/bash
                set -e

                echo "Starting fresh Tomcat installation..."

                # Function to check command status
                check_status() {
                    if [ \$? -eq 0 ]; then
                        echo "✓ Success: \$1"
                    else
                        echo "✗ Error: \$1"
                        exit 1
                    fi
                }

                # 1. Create tomcat user
                echo "Creating tomcat user..."
                sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat 2>/dev/null || true
                check_status "Created tomcat user"

                # 2. Create installation directory
                echo "Creating Tomcat directory..."
                sudo rm -rf /opt/tomcat
                sudo mkdir -p /opt/tomcat
                check_status "Created directory"

                # 3. Download and extract Tomcat
                echo "Downloading Tomcat..."
                TOMCAT_VERSION="v10.1.31"
                sudo wget "https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.31/bin/apache-tomcat-10.1.31-deployer.tar.gz" -O tomcat.tar.gz
             
                check_status "Downloaded Tomcat"

                echo "Extracting Tomcat..."
                sudo tar xzf tomcat.tar.gz -C /opt/tomcat
                check_status "Extracted Tomcat"

                # 4. Create symbolic link
                echo "Creating symbolic link..."
                sudo ln -sf /opt/tomcat/apache-tomcat-\ /opt/tomcat/latest
                check_status "Created symbolic link"

                # 5. Set permissions
                echo "Setting permissions..."
                sudo chown -R tomcat: /opt/tomcat
                sudo chmod +x /opt/tomcat/latest/bin/*.sh
                check_status "Set permissions"

                # 6. Clean up
                echo "Cleaning up..."
                sudo rm tomcat.tar.gz
                check_status "Cleaned up"

                # 7. Verify installation
                echo "Verifying installation..."
                if [ -f "/opt/tomcat/latest/bin/startup.sh" ]; then
                    echo "✓ startup.sh found at: /opt/tomcat/latest/bin/startup.sh"
                else
                    echo "✗ startup.sh not found! Installation may have failed."
                    exit 1
                fi

                # 8. Create systemd service
                echo "Creating systemd service..."
                sudo tee /etc/systemd/system/tomcat.service << 'SERVICE_EOF'
                [Unit]
                Description=Apache Tomcat
                After=network.target

                [Service]
                Type=forking
                User=tomcat
                Group=tomcat

                Environment="JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto"
                Environment="CATALINA_HOME=/opt/tomcat/latest"
                Environment="CATALINA_BASE=/opt/tomcat/latest"
                Environment="CATALINA_OPTS=-Xms512M -Xmx1024M"

                ExecStart=/opt/tomcat/latest/bin/startup.sh
                ExecStop=/opt/tomcat/latest/bin/shutdown.sh

                RestartSec=10
                Restart=always

                [Install]
                WantedBy=multi-user.target
                SERVICE_EOF

                check_status "Created service file"

                # 9. Start service
                echo "Starting Tomcat service..."
                sudo systemctl daemon-reload
                sudo systemctl start tomcat
                sudo systemctl enable tomcat
                check_status "Started Tomcat service"

                echo "
                Installation completed!
                ----------------------
                Verify installation with these commands:

                1. Check service status:
                sudo systemctl status tomcat

                2. Check process:
                ps aux | grep tomcat

                3. Check logs:
                sudo journalctl -u tomcat.service

                4. Access Tomcat:
                http://localhost:8080

                Installation paths:
                - Installation directory: /opt/tomcat/latest
                - Startup script: /opt/tomcat/latest/bin/startup.sh
                - Shutdown script: /opt/tomcat/latest/bin/shutdown.sh
                - Configuration: /opt/tomcat/latest/conf/
                - Logs: /opt/tomcat/latest/logs/
                "
                EOF


  tags = {
    Name = "Primary Tomcat Instance"
  }
}
