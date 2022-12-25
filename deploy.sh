docker build -t gmbroth/multi-client:latest -t gmbroth/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gmbroth/multi-server:latest -t gmbroth/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gmbroth/multi-worker:latest -t gmbroth/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gmbroth/multi-client:latest
docker push gmbroth/multi-server:latest
docker push gmbroth/multi-worker:latest

docker push gmbroth/multi-client:$SHA
docker push gmbroth/multi-server:$SHA
docker push gmbroth/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=gmbroth/multi-server:$SHA
kubectl set image deployment/client-deployment client=gmbroth/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gmbroth/multi-worker:$SHA
