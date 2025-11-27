# ElixirT1

## Project Directory

* `assets` - Frontend assets (JavaScript, CSS, fonts, images) managed by Tailwind and Esbuild
* `config` - Application configuration files (dev, test, prod)
* `lib` - Application source code
  * `elixir_t1` - Core business logic and context modules
  * `elixir_t1_web` - Web interface (Controllers, Views, LiveViews, Components)
* `priv` - Private assets, including database migrations and static files served by Phoenix
* `test` - Application tests
* `mix.exs` - Project configuration and dependency management

## GitHub Pages via GitHub Actions

Since Phoenix is a dynamic application framework, GitHub Pages (which hosts static content) is typically used to host the project's **documentation**.

To deploy ExDoc documentation to GitHub Pages automatically:

1.  **Add ExDoc dependency**:
    Ensure `ex_doc` is listed in your `mix.exs` dependencies:
    ```elixir
    {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ```

2.  **Create a Workflow**:
    Create a file at `.github/workflows/deploy_docs.yml` with the following content:

    ```yaml
    name: Deploy Docs
    on:
      push:
        branches: ["main"]
    permissions:
      contents: write
    jobs:
      deploy:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v4
          - uses: erlef/setup-beam@v1
            with:
              otp-version: "26.0"
              elixir-version: "1.15"
          - run: mix deps.get
          - run: mix docs
          - uses: peaceiris/actions-gh-pages@v3
            with:
              github_token: ${{ secrets.GITHUB_TOKEN }}
              publish_dir: ./doc
    ```

3.  **Configure Repository**:
    *   Go to your repository **Settings** > **Pages**.
    *   Under **Build and deployment**, select **Deploy from a branch**.
    *   Select `gh-pages` as the branch (this branch will be created by the action).



## local

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
