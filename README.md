
coffee-pattern: use pattern matching like syntax in CoffeeScript
------

### Usage

We don't have pattern matching in CoffeeScript, poor language...

Install from NPM and use in CoffeeScript code:

```bash
npm install --save coffee-pattern
```

```coffee
{match} = require 'coffee-pattern'

match 'string or number here'
  /^head/, (data) -> print "#{data} matches head"
  /tail$/, (data) -> print "#{data} matches tail"
  5, (data) -> print 'it is five'
  null, (data) -> print "#{data} has no matching pattern"
```

### License

MIT