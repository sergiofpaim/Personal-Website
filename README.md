# Personal Website

This is a personal website created by me and a friend using **Ruby on Rails**, **SQLite**, and **Active Record** as the ORM.

The application works as a backend layer that dynamically hydrates a static HTML hosted on **GitHub Pages (github.io)**.

## Idea

The main goal of this project was to combine the simplicity and free hosting of GitHub Pages with the flexibility of a Rails-powered backend.

By doing this, we are able to:

* Use GitHub’s DNS and static hosting
* Keep a dynamic backend powered by Rails
* Manage and persist data using Active Record with SQLite

## Tech Stack

* **Ruby on Rails** — backend framework
* **SQLite** — lightweight database
* **Active Record** — ORM for database interaction
* **GitHub Pages (github.io)** — static frontend hosting

## How it works

The static frontend is served via GitHub Pages, while the Rails application provides dynamic data. The frontend is then hydrated with this data, enabling a hybrid approach between static and dynamic content.

## Goals

* Keep deployment simple and low-cost
* Leverage GitHub infrastructure (DNS + hosting)
* Maintain flexibility for dynamic features

---

A simple experiment blending static and dynamic web architectures 🚀
