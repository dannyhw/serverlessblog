---
title: First Post, no hero.
date: 2016-01-22
layout: Post
---

This is my first post. This website was created using phenomic and hosted in S3.

Code is highlighted by default.

```js
const StatelessComponent = (props) => {
  return (
    <div>
      I‘m a stateless component that accepts children
      { props.children }
    </div>
  )
}

// ...

  return (
    <StatelessComponent>
      Example of child
    </StatelessComponent>
  )
```
