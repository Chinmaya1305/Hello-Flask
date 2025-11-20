# Demo Steps (quick)

1. Start local registry:
   `docker run -d --restart=always --name registry-local -p 10090:5000 registry:2`

2. Build & push:
   `docker build -t localhost:10090/hello-flask:latest .`
   `docker push localhost:10090/hello-flask:latest`

3. Create kind cluster:
   `kind create cluster --name dev-cluster`

4. Load image into kind (optional):
   `kind load docker-image localhost:10090/hello-flask:latest --name dev-cluster`

5. Apply k8s:
   `kubectl apply -f k8s/deployment.yaml -f k8s/service.yaml`
   `kubectl rollout status deployment/hello-flask`

6. Test:
   `curl http://localhost:31555/`

7. Start Jenkins (for CI):
   `docker run -d --name jenkins-dev -p 9111:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts`

8. In Jenkins create a Pipeline job pointing at this repo (use SSH/Token credentials) — the included `Jenkinsfile` will build → push → apply.

