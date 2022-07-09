<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#File Structure">File Structure</a></li>
    <li><a href="#Docker">Docker</a></li>
    <li><a href="#Backend">Backend</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



## File Structure
    .
    ├── ...
    ├── forntend                        # all Ui code
    ├── backend                         # all backend code
    │   ├── app                         # flask app 
    │   ├── ml                          # ml code
    │   ├── Dockerfile                  # docker file for backend container
    │   ├── requirements.txt            # all backend requirement for this project
    │   ├── server.py                   # run the app
    │   └── ...
    ├── docker-compose.ymal             # mataining all 5 docker containers
    └── README.md                       # readme file brief instruction of this project

## Docker
### Run all containers
All command are for linux, remove sudo if you are using mac or windows
```
sudo docker-compose up  --force-recreate -d  
```
### Stop all containers
```
sudo docker-compose down --remove-orphans
```

### Containers Structure
Container | port | describtion     
--- | --- | --- 
backend | 5002 | ML and flask app
rntend |        | Flutter app
mongodb | 27018 | Mongodb database

## Backend
route coming soom
```json
{
    "/": {
        "des": "detail of all route",
        "method": "get"
    },
    "/startsession": {
        "des": "start session",
        "method": "get"
    },
    "/addresume": {
        "des": "add resume",
        "method": "post",
        "body": {
            "resume":"file"
        }
    },
    "/submit": {
        "des": "return all parsed data of resume",
        "method": "get"
    },
    "/addformdata": {
        "des": "add form info",
        "method": "post",
        "body": {
            "json object"
        }
    },
    "/findskillsets": {
        "des": "get resume based on skillset",
        "method": "post",
        "body": 
            {
              "Skillsets": [ ]
            }
        
    }
}
```
