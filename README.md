# I-test

Quotes web-crawler.

## Getting Started

### Prerequisites

- RVM
- Ruby 2.6.5
- MongoDB 4.2.4

### Installation

Create a `.env` file in root and set following variables:

```
DATABASE_HOST=<value> (eg.:localhost:27017)
JWT_SECRET_KEY=<value> (can be generated with `rails secret`)
```

Install dependencies:

```
bundle
```

## Development

Start the database, if it is not already:

```
sudo systemctl start mongod
```

Running locally:

```
rails s
```

Lint the code:

```
rubocop
```

Running tests:

```
rails test
```

## Basic Usage

Simple API to crawl quotes by [toScrap](http://quotes.toscrape.com/) and store in mongoDB.

### How to Use

**NOTE:** First of all, you need a authentication key. You should register as a user, or sign in, if already registered:

#### Authentication:

**POST /auth/registration**

Create a new user.

- Returns

  User (\_id, name and email) as body (json). And access token, as `Authorization` header (bearer).

- Body
  - `user[:name]` - Your name
  - `user[:email]` - Your e-mail
  - `user[:password]` - Your password

**POST /auth/session**

Sign in user.

- Returns

  User (\_id, name and email) as body (json). And access token, as `Authorization` header (bearer).

- Body
  - `user[:email]` - Your e-mail
  - `user[:password]` - Your password

**DELETE /auth/session**

Sign out user.

- Returns

  204 - No content.

- Headers
  - `Authentication` - Authentication header in format bearer format (`"Bearer SOME_SECRET_HASH"`)

- Body
  - `user[:email]` - Your e-mail
  - `user[:password]` - Your password

#### API:

**GET /api/quotes/:tag**

Crawl quotes in [toScrap](http://quotes.toscrape.com/), save in database and return as body. If tag is already searched, just return as body.

- Returns

```js
{
  "quotes": [
    {
      "quote": "Quote text",
      "author": "Author name",
      "author_about": "link to author",
      "tags": ["array", "of", "tags"]
    }
    // ...
  ]
}
```

- URL Parameter
  - `tag` - Quote tag to search. (eg.: `inspirational`)

- Headers
  - `Authentication` - Authentication header in format bearer format (`"Bearer SOME_SECRET_HASH"`)

## Authors

Alexandre Magro (alx.magro@gmail.com)
