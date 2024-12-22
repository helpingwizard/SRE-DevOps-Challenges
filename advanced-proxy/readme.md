Requirements:
Service Setup:
Install and run Grafana and Jenkins locally or via Docker.
Nginx Reverse Proxy:
Configure Nginx to route requests:
https://grafana.local → Grafana
https://jenkins.local → Jenkins (with Basic Authentication).
Enable SSL:
Generate and configure a self-signed SSL certificate for HTTPS access.
Redirect all HTTP traffic to HTTPS.
Secure Jenkins:
Restrict Jenkins/Grafana access with Basic Authentication.
Validate Configuration:
Access both services via the configured domains securely using HTTPS.

Implement Rate Limiting in Nginx:
Set up Nginx rate limiting to prevent abuse by restricting the number of requests per second from each IP address.
Ensure that rate limits are applied for access to Jenkins.
