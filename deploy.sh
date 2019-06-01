docker build -t mohamedbenchaliah/multi-client:latest -t mohamedbenchaliah/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mohamedbenchaliah/multi-server:latest -t mohamedbenchaliah/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mohamedbenchaliah/multi-worker:latest -t mohamedbenchaliah/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mohamedbenchaliah/multi-client:latest
docker push mohamedbenchaliah/multi-server:latest
docker push mohamedbenchaliah/multi-worker:latest

docker push mohamedbenchaliah/multi-client:$SHA
docker push mohamedbenchaliah/multi-server:$SHA
docker push mohamedbenchaliah/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
