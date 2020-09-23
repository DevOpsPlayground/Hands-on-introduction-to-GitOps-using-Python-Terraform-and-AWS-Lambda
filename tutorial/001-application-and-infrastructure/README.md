# Application

We begin by looking at our application. There are four main layers to the complete application:

## Storage Layer 

We use a NoSQL database - DynamoDB - to store session data for out application. The session is 

## Application Layer

Our application uses a Function based approach, splitting each piece of functionality into small, isolated functions.

### List / Get

### Add

### Edit

### Delete


## Interface Layer

## API Layer

A public API integrates our user interface with the underlying project functionality. The user has no access to the underlying application layer, but can interact with it via the API.