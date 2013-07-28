
{match} = require './pattern'

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
      null, 1
    expect(ret).toBe(1)

  it 'has callbacks', ->
    ret = match 'string',
      1, 1
      'string', (data) -> data + ' x'
      null, 1
    expect(ret).toBe('string x')

  it 'knows regular expressions', ->
    ret = match 'head',
      /^head/, 'this is head'
      /tail$/, 'this is tail'
      null, 'nothing'
    expect(ret).toBe('this is head')

  it 'looks nice when have callbacks', ->
    ret = match 'anything',
      'head', (data) -> console.log 'it is ok'
      'tail', (data) -> console.log 'still fun'
      'complecated', (data) ->
        say = 'long tails'
        console.log say
      null, (data) -> console.log 'ok anything'
    expect(ret).toBe(undefined)

  it 'returns undefined when really no match', ->
    ret = match 'something'
    expect(ret).toBe(undefined)