---
layout: post
title: "Java knowledge review"
date: 2026-03-26
excerpt: "Recently, I've been reviewing Java knowledge to prepare for job interviews."
tags: [ Java, technology, interview ]
comments: true
---

# Java knowledge review

Recently, I've been reviewing Java knowledge to prepare for job interviews.

## Java String

方法参数传递：按值传递和按引用传递

Java method parameter passing: pass by Value and pass by Reference

```java

@Test
public void testString() {
    String str = "Old";
    change(str);
    System.out.println(str); // Old

    String s = "Java";
    s.concat(" Rocks");
    System.out.println(s); // Java
}

public void change(String s) {
    s = "New";
}
```

## Collection

```java

@Test
public void testStreamMap() {
    System.out.println(Stream.of("Java", "Python", "Go").filter(s -> s.length() > 3).count()); // 2
    Stream<Integer> s = Stream.of(1, 2, 3);
    s.map(x -> x * 2).forEach(System.out::println); // 2 4 6
    Stream<Integer> si = Stream.of(1, 2, 3);
    si.map(x -> x * 2);
    si.forEach(System.out::println); // IllegalStateException: stream has already been operated upon or closed
}

@Test
public void testGeneric() {
    List<String> a = new ArrayList<>();
    List<Integer> b = new ArrayList<>();
    System.out.println(a.getClass() == b.getClass()); // true
}
```
