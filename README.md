
coffee-pattern: write pattern matching in CoffeeScript syntax
------

### Usage

CoffeeScript doesn't support pattern matching, poor language...

Install from NPM and use in CoffeeScript code:

```bash
npm install --save coffee-pattern
```

```coffee
{match} = require 'coffee-pattern'

match 'string or number here',
  'string', 'string'
  /^head/, (data) -> print "#{data} matches head"
  /tail$/, (data) -> print "#{data} matches tail"
  /fine/, 'fine'
  5, (data) -> print 'it is five'
  null, -> print 'matches null not undefined'
  undefined, (data) -> print "#{data} has no matching pattern"
  key: -> 'object as a shortcut'
```

or more crazy:

```coffee
{M} = require 'coffee-pattern'

M (a is that),
  yes, -> M (b is that),
    yes, -> print 'do something'
  no, -> M c,
    'such string', -> that
    /such\s|w+/, -> 'that too'
    undefined, -> M ret,
      'ok', 'OK'
      'no', 'NO'
  undefined, 'fallback'
```

### features

* normally if the pattern and data are equal, they match.
* if the pattern is a regular expression, than use expression
* while there's no matched rule, `null` or `undefined` would be used
* it returns `undefined` if there's nothing to return

### More

Read `test.Spec.coffee` to see the cases supported.  
Read `pattern.coffee` to see how this function works.  
Run tests with `npm test` with Jasmine and CoffeeScript.  

This is a simple and dirty solution, send me PRs if you have better ideas :)

### License

MIT