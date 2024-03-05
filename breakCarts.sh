
#### Break Carts app ####

kubectl apply -k crossplane/broken-iam-policy


<<EOF
Carts old app is deployed on ARGO CD, We need to move to carts app that utilises crossplane created external dynamo db
Replace carts-old with carts and add crossplane-dynamodb in values.yaml in the app-of-apps dir and push changes to your repo
after running the above commands as a script
EOF