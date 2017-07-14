# hack 3 - SuperCollider Chaos Audiovisual Composition

- I want to expand upon 'A Chaotic Map in curved Waves' by plotting the same waves in various different combinations on one window, in some kind of grid format maybe
- This was inspired by accidentally opening up another scope during a composition and superimposing two scopes together
- ScopeView reads from a buffer, so I need to poll server data into a buffer
- And then make a bunch of ScopeViews with different settings which will read from the same buffer at different settings
- The frame rate of the manually-created scopes is very low and i'm not entirely sure why this is...
- It appears that there is only one global control of x.zoom, which is a thing if