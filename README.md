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

Running tests:

```
rails test
```

## Authors

Alexandre Magro (alx.magro@gmail.com)
