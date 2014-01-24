# CoffeeScript Debouncing Test

This is a object-oriented CoffeeScript implementation of the debouncing technique described by John Hann in his article [Debouncing JavaScript Methods](http://unscriptable.com/2009/03/20/debouncing-javascript-methods/).

I initially consulted the [debounce example](http://coffeescriptcookbook.com/chapters/functions/debounce) at CoffeeScript Cookbook, but their example had a scoping error and would not run in a real object.

I've converted the code into a callback model to maintain the object scope of the handler that is being debounced.

In order to accommodate multiple, simultaneous debouncing schemes, the method creates an object as an instance property, in which it tracks timeouts. I don't love this technique, but it seems effective as long as multiple callbacks aren't exactly the same.

```
handleSomething: (event) =>
	@debounce 500, false, =>
		@expensiveMethod event.something

debounce: (threshold, execAsap, callback) =>
	@debounceTimeout ?= {}
	if @debounceTimeout[callback]
		clearTimeout @debounceTimeout[callback]
	else if execAsap
		callback()
	@debounceTimeout[callback] = setTimeout callback, threshold
```


