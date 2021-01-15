#!/bin/bash

while [ -z $reponse ] || [ $reponse != 'oui' ]; do
	read -p 'Dites oui : ' reponse
done
