# Steps to run Gatekeeper demo in Argo

### Please Note: the following is draft demo flow and it will further automated in the near future

### Deploy table without 'owner' tag

#### Step 1
Make sure that table.yaml under table-tags dir looks as below
```
apiVersion: dynamodb.aws.upbound.io/v1beta1
kind: Table
metadata:
  annotations:
    meta.upbound.io/example-id: dynamodb/v1beta1/globaltable
  name: example
spec:
  forProvider:
    attribute:
      - name: myAttribute
        type: S
    hashKey: myAttribute
    readCapacity: 1
    region: us-west-1
    writeCapacity: 1
    # tags:
    #   key: owner
    #   value: dev
```
Make sure $GITOPS_REPO_URL_ARGOCD has been setup as your git repo and you are logged in to argocd via cli, if not then use the following command

```bash
argocd login $(kubectl get svc argo-cd-argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname') --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure
```

#### Step 2
Use the following command to deploy the above Dynamodb table using ArgoCD
```bash
argocd app create gatekeeper-table --repo $GITOPS_REPO_URL_ARGOCD --path gatekeeper/table-tags --dest-server https://kubernetes.default.svc
```
Manually click sync on the ArgoCD ui to see the actual Sync Failed message


### Deploy table with 'owner' tag

#### Step 1
Update table.yaml under table-tags dir by uncommenting the tags field
```
apiVersion: dynamodb.aws.upbound.io/v1beta1
kind: Table
metadata:
  annotations:
    meta.upbound.io/example-id: dynamodb/v1beta1/globaltable
  name: example
spec:
  forProvider:
    attribute:
      - name: myAttribute
        type: S
    hashKey: myAttribute
    readCapacity: 1
    region: us-west-1
    writeCapacity: 1
    tags:
      key: owner
      value: dev
```
Push these changes to your Git repo


#### Step 2
Sync the gatekeeper-table app in ArgoCD and check the deployment