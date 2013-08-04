
{match} = require './pattern.coffee'

describe 'test patterns', ->
  it 'matches number', ->
    ret = match 1,
      1, 1
      2, 2
      3, 4
    expect(ret).toBe(1)

  it 'matches string', ->
    ret = match 'string',
      1, 1
      'string', 'string'
    expect(ret).toBe('string')

  it 'has default value', ->
    ret = match 'string',
      undefined, 1
    expect(ret).toBe(1)

  it 'has callbacks', ->
    ret = match 'string',
      1, 1
      'string', (data) -> data + ' x'
      undefined, 1
    expect(ret).toBe('string x')

  it 'knows regular expressions', ->
    ret = match 'head',
      /^head/, 'this is head'
      /tail$/, 'this is tail'
      undefined, 'nothing'
    expect(ret).toBe('this is head')

  it 'looks nice when have callbacks', ->
    ret = match 'anything',
      'head', (data) -> console.log 'it is ok'
      'tail', (data) -> console.log 'still fun'
      'complecated', (data) ->
        say = 'long tails'
        console.log say
      undefined, (data) -> console.log 'ok anything'
    expect(ret).toBe(undefined)

  it 'returns undefined when really no match', ->
    ret = match 'something'
    expect(ret).toBe(undefined)

  it 'also accepts function as pattern', ->
    isString = (x) -> (typeof x) is 'string'
    ret = match 'string',
      isString, 1
    expect(ret).toBe(1)

  it 'use null as a pattern', ->
    ret = match null,
      null, 'is null'
      undefined, 'default one'
    expect(ret).toBe('is null')

  it 'data without matching falls to undefined', ->
    ret = match 'not found',
      null, 'at null'
      undefined, 'right'
    expect(ret).toBe('right')

  it 'only chooses one pattern', ->
    count = 0
    match '1',
      null, -> count += 1
      undefined, -> count += 1
      1, -> count += 1
      '1', -> count += 1
    expect(count).toBe(1)

  it 'chooses only one even nested', ->
    count = 0
    match 1,
      null, -> count += 1
      1, -> match 1,
        1, -> count += 1
        undefined, -> count += 1
      undefined, -> count += 1
    expect(count).toBe(1)

  it 'supports objects as shortcuts', ->
    ret = match 'name',
      '': -> 'empty string'
      name: -> 1
      undefined, -> 2
    expect(ret).toBe(1)

  it 'dont count wrong on objects', ->
    ret = match 'e',
      a: 'a'
      b: 'b'
      c: 'c'
      d: 'd'
      'e', 'e'
      undefined, 'nothing'
    expect(ret).toBe('e')