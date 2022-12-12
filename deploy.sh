docker build -t araqi/multi-client:latest -t araqi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t araqi/multi-server:latest -t araqi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t araqi/multi-worker:latest -t araqi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push araqi/multi-client:latest
docker push araqi/multi-server:latest
docker push araqi/multi-worker:latest
docker push araqi/multi-client:$SHA
docker push araqi/multi-server:$SHA
docker push araqi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=araqi/multi-server:$SHA
kubectl set image deployments/client-deployment client=araqi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=araqi/multi-worker:$SHA

