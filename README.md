# SignCsr

The SignCsr Signs a CSR (Certificate Signing Request) coming from a device with
NervesKey. It sends back the signed certificate back which will be used to 
provision aux certificates in NervesKey.

By default, the service is running on port `9000`. You can change it in config 
if you want to.

## Instructions
To be able to sign the incoming CSR you need to place signer CA certificates in directory
`signer_certs`. Then you need to specify it's name in config.exs without the extension.
Make sure certificate and key file name and same and they only differ in extension. 
Make sure extensions are as `.cert` for certificate and `.key` for key file.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
