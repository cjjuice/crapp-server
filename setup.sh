#!/bin/bash

rails g model bathroomtype type:string
rails g model bathroom name:string address:string city:string state:string zip:string lat:string lng:string isHandicapAccessible:boolean isPublic:boolean isFamily:boolean isGreen:boolean isUnisex:boolean isHandsFree:boolean hasProductDispenser:boolean hasAttendent:boolean hasSignage:boolean hasWifi:boolean bathroomtype:references
rails g model review reviewtext:string bathroom:references
rails g model scoretype type:string
rails g model score value:integer bathroom:references scoretype:references 
