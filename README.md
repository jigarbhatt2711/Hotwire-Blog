# ⚡ Hotwire Blog — Rails 8

A real-time blog application built with **Ruby on Rails 8** and **Hotwire** (Turbo + ActionCable). Create, edit, and delete posts with **zero page reloads** and **real-time multi-user updates** — all without writing a single line of JavaScript!

---

## 🎥 Features

- ✅ **Turbo Drive** — Fast page navigation without full reload
- ✅ **Turbo Frames** — Inline post editing inside the card
- ✅ **Turbo Streams** — Real-time CRUD without page reload
- ✅ **ActionCable** — Multi-user real-time updates via WebSocket
- ✅ **Zero JavaScript** — Everything powered by Hotwire
- ✅ **Bootstrap 5** — Clean responsive UI
- ✅ **Rails 8** — Latest Rails with Solid Queue and Solid Cache

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Backend | Ruby on Rails 8 |
| Real-time | Hotwire (Turbo + ActionCable) |
| Frontend | Turbo Frames + Turbo Streams |
| Styling | Bootstrap 5 |
| Database | SQLite3 (development) |
| WebSocket | ActionCable (async adapter) |
| JS Management | Import Maps |

---

## ⚙️ Requirements

- Ruby `3.3.0+`
- Rails `8.x`
- SQLite3

> No Node.js, npm, or webpack required! ✅

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/hotwire_blog.git
cd hotwire_blog
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Setup database

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Start the server

```bash
bin/dev
```

### 5. Open browser

```
http://localhost:3000
```

---

## 🪄 How Hotwire works in this app

### Turbo Drive
Automatically intercepts all link clicks and form submissions — no full page reloads.

### Turbo Frames
Each post card is wrapped in a `turbo_frame_tag`. Clicking **Edit** swaps the card with an edit form inline — no navigation needed.

```erb
<%= turbo_frame_tag dom_id(post) do %>
  <!-- post card content -->
<% end %>
```

### Turbo Streams
After create, update, or delete — Rails sends tiny HTML instructions to the browser:

```erb
<%# create.turbo_stream.erb %>
<%= turbo_stream.prepend "posts_list", partial: "post", locals: { post: @post } %>
<%= turbo_stream.update  "post_form",  partial: "form", locals: { post: Post.new } %>
```

```erb
<%# update.turbo_stream.erb %>
<%= turbo_stream.replace dom_id(@post), partial: "post", locals: { post: @post } %>
```

```erb
<%# destroy.turbo_stream.erb %>
<%= turbo_stream.remove dom_id(@post) %>
```

### ActionCable — Real-time Multi User
One line in the model broadcasts to ALL connected users:

```ruby
# app/models/post.rb
broadcasts_to ->(post) { "posts" },
  inserts_by: :prepend,
  target: "posts_list"
```

One line in the view subscribes to the channel:

```erb
<%= turbo_stream_from "posts" %>
```

---

## 📁 Project Structure

```
app/
├── channels/
│   └── posts_channel.rb              # ActionCable channel
├── controllers/
│   └── posts_controller.rb           # CRUD with respond_to turbo_stream
├── models/
│   └── post.rb                       # broadcasts_to for real-time
└── views/
    └── posts/
        ├── index.html.erb            # turbo_stream_from + posts_list
        ├── edit.html.erb             # turbo_frame_tag dom_id
        ├── _post.html.erb            # turbo_frame per post card
        ├── _form.html.erb            # shared form partial
        ├── create.turbo_stream.erb   # prepend + reset form
        ├── update.turbo_stream.erb   # replace post card
        └── destroy.turbo_stream.erb  # remove post card
```

---

## 🔄 Real-time Demo

```
Open TWO browser windows side by side:
Window 1 → http://localhost:3000
Window 2 → http://localhost:3000

Window 1: Create a new post
Window 2: New post appears instantly! ⚡

Window 1: Edit and update a post
Window 2: Updated post shows instantly! ⚡

Window 1: Delete a post
Window 2: Post disappears instantly! ⚡

Zero JavaScript written! 🔥
```

---

## 📊 Turbo Stream Actions Used

| Action | Used for | Effect |
|---|---|---|
| `prepend` | CREATE | New post added at top |
| `replace` | UPDATE | Post card swapped |
| `remove` | DELETE | Post card removed |
| `update` | FORM RESET | Form cleared after submit |

---

## 🧪 Running Tests

```bash
rails test
```

---

## 👨‍💻 Author

**Jigar Bhatt**
- 🌐 [jigarbhatt2711.github.io](https://jigarbhatt2711.github.io)
- 💼 [linkedin.com/in/jigarbhatt271](https://linkedin.com/in/jigarbhatt271)
- 💻 [github.com/jigarbhatt2711](https://github.com/jigarbhatt2711)
- 📱 +91 99742 44945

---

## 📚 What I Learned

- Hotwire Turbo Drive, Frames and Streams
- ActionCable WebSocket real-time broadcasting
- `broadcasts_to` one-line real-time updates
- `turbo_stream_from` subscription in views
- Building SPA experience with zero JavaScript
- Rails 8 Import Maps for JS management

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙏 References

- [Hotwire Documentation](https://hotwired.dev)
- [Rails Guides — ActionCable](https://guides.rubyonrails.org/action_cable_overview.html)
- [Turbo Handbook](https://turbo.hotwired.dev/handbook/introduction)
- [Rails 8 Release Notes](https://rubyonrails.org/2024/11/7/rails-8-0-released)