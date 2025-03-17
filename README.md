# makersBnB

## To use

Clone to your machine, run bundle, set up the databases (instructions below), run rackup and then on the browser go to localhost:xxxx (xxxx being the port number on rackup ie 4567)

## To set up the database

1. Connect to psql
2. Create the database using the psql command CREATE DATABASE makers_bnb;
3. Connect to the database using the pqsl command \c makers_bnb;
4. Run the queries we have saved in db/migrations

## To set up the test database

1. Connect to psql
2. Create the database using the psql command CREATE DATABASE makers_bnb_test;
3. Connect to the database using the pqsl command \c makers_bnb_test;
4. Run the queries we have saved in db/migrations

## Headline specifications

* Any signed-up user can list a new space.
* Users can list multiple spaces.
* Users should be able to name their space, provide a short description of the space, and a price per night.
* Users should be able to offer a range of dates where their space is available.
* Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
* Nights for which a space has already been booked should not be available for users to book that space.
* Until a user has confirmed a booking request, that space can still be booked for that night.

## Nice-to-haves

* Users should receive an email whenever one of the following happens:
* They sign up
* They create a space
* They update a space
* A user requests to book their space
* They confirm a request
* They request to book a space
* Their request to book a space is confirmed
* Their request to book a space is denied
* Users should receive a text message to a provided number whenever one of the following happens:
* A user requests to book their space
* Their request to book a space is confirmed
* Their request to book a space is denied
* A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
* Basic payment implementation though Stripe.

## MVP

Owner can list one or more spaces.\
Owner can add space with name, description and ppn.\
Owner should be able to offer a range of dates where their space is available.

Holiday maker can view spaces.\
Holiday maker can click on individual space for more information.\
Holiday maker can click on individual space to make enquiry.

## User Stories

As a user, so I can sign up\
I would like a sign up page to store name, pwd, email

As a user, so i can see all the listings,\
I would like to see a list of all spaces

As a user, so I can post my space(s),\
I would like to submit my listing with a name, description, ppn and dates

As a user, so I can see more information on the space,\
I would like to click on a specific listing

As a user, so I can make an enquiry,\
I would like to email the space owner

As a user, so I can see my account info,\
I want to be able to visit my profile page

As a user, so I can view all my listings,\
I want to be able to see all profile page

As a user, so I can make changes to my listings,\
I want to be able to edit my listings

As a user, so I can make remove a listing,\
I want to be able to delete it from my profile page

## Domain Model

| Object | Message |
| --|-- |
| Listing | .initialize |
| Name | |
| Description | |
| PPN | |
|  | .all ** |
|  | .create** |
|  | .update |
|  | .delete |
|  | .find |
|User  | .all |
|  | .create |

## CRC

Database:\
makers_bnb\
makers_bnb_test

Tables:\
Listings: id primary key / foreign key(user id)/ name/ description/ price\
User table: id primary / name/ username/ email/ password\
Dates table?:
Domain

## Agreed working day

(i.e. stand-ups/ pull requests/ retros)

=======
