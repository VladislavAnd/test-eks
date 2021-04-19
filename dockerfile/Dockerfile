FROM hashicorp/terraform:0.13.6

RUN apk add --no-cache py-pip 'python3>3.7' jq curl wget
RUN pip install awscli
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && mv kubectl /usr/local/bin/ && chmod +x /usr/local/bin/kubectl
ENV HELM_VERSION=3.5.4

RUN wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf ./linux-amd64 && helm repo add stable https://charts.helm.sh/stable

ENTRYPOINT ["/bin/sh"]


