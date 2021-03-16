defmodule SignCsrWeb.SignView do
  use SignCsrWeb, :view

  def render("index.json", %{message: message}) do
    %{
      data: %{ response: message }
    }
  end

  def render("sign.json", %{device_cert_pem: device_cert_pem}) do
    %{ data: device_cert_pem }
  end

end
