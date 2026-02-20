#!/bin/bash

curl -fsSL https://apt.cucumber-space.online/key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/cucumber-space.key.gpg
echo 'deb [signed-by=/etc/apt/keyrings/cucumber-space.key.gpg] https://apt.cucumber-space.online ./' | sudo tee /etc/apt/sources.list.d/cucumber-space.list > /dev/null
sudo apt update
sudo apt install yandex-music
