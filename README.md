# cs3219-taskA3

## **Task A3: Advanced Features Kubernetes**
This repository contains the files needed for CS3219 OTOT Task A3.

In this task, I have learnt to set up and deploy advanced features of kubernetes, note that in the tasking, I will deploying subtask 1 and 2 concurrently, and subtask 3 seperately. 

The kubernetes service set up uses **Kubernetes: docker for desktop** for the cluster.

--- 
#### How to deploy (subtask 1 and 2):

1. Ensure that you have Kubernetes and Docker installed in your machine. Kubernetes will run via **kubectl**.  
&nbsp;
2. Either download the files via the Git GUI, or by the following command
  
        git clone https://github.com/kormingsoon/cs3219-taskA3.git

3. Ensure that the Docker Desktop Enables Kubernetes.
&nbsp;
4. Run the following commands to build and verify that the image is created.
        
        docker build -t cs3219-nginx-image .
        docker image ls
    
5. Run the following commands to run Kubernetes. The second command will allow you to check that the pods are running successfully.

        kubectl apply -f .\cs3219-nginx-deployment.yaml
        kubectl get pods  -o wide

6. Run the follwing command to allow the docker application to be accessible by a service rendered on Kubernetes.

        kubectl apply -f .\cs3219-nginx-svc.yaml

7. Run the following commands for the ingress deployment.
   
        kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/cloud/deploy.yaml

        kubectl apply -f ./cs3219-sticky-ingress.yaml

8. To access the deployed app, add a line 
   
        127.0.0.1 kormingsoon.com 
    to your C:\Windows\System32\drivers\etc\hosts file and save it. You will need Administrator privileges to do that. This will vary depending on your operating systems.
&nbsp;

9.  View the cookies view the browser console and refresh the page to see that the cookies does not change.

---
#### How to deploy horizontal pod auto-scale (subtask 3):
1. Run ```cd partThree``` in your command prompt to access the folder.
&nbsp;
2. Run the following commands to build and verify that the image is created.
        
        docker build -t php-apache -f ./Dockerfile .
        docker image ls

3. Run the following commands to spin up the deployment and service.
        
        kubectl apply -f ./components.yaml
        kubectl apply -f ./php-deploy-service.yaml

4. Next, we will create the autoscale for the deployment earlier, in the second command we will then see that the Horizontal Pod Autoscale is created for the deployment.

        kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
        kubectl get hpa

5. Open another command prompt and run the following command.
   
        kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"

6. In the original command prompt, we will run the command to monitor and see that the target is slowly overextended.
        
        kubectl get hpa --watch

7. After seeing that the target is overextended, we can run the following command to see that the number of replicas increased.

        kubectl get deployment php-apache

8. Enter Ctrl + C in the load generator command prompt to stop feeding the artificial load. 