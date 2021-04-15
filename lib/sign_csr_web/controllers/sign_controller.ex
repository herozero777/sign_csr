defmodule SignCsrWeb.SignController do
  use SignCsrWeb, :controller

  use Application
  require Logger

  @otp_app Mix.Project.config()[:app]
  @build_year DateTime.utc_now().year

  def index(conn, _params) do
    render( conn, "index.json", message: "Salam, the Sign CSR server is up and running!")
  end


  def sign(conn, params) do
    check_time()

    Logger.debug "Params: #{inspect params}"

    # Extract CSR
    csr_str = case params do
      %{"csr_str" => csr_str} -> csr_str
      _ ->
#        Logger.error "csr_str not found in params"
        raise "csr_str not found in params"
    end
    b64_device_sn = case params do
      %{"device_sn" => b64_device_sn} -> b64_device_sn
      _ ->
#        Logger.error "device_sn not found in params"
        raise "device_sn not found in params"
    end
    manufacturer_sn = case params do
      %{"manufacturer_sn" => manufacturer_sn} -> manufacturer_sn
      _ ->
#        Logger.error "manufacturer_sn not found in params"
        raise "manufacturer_sn not found in params"
    end
    Logger.debug "b64_device_sn:"
    Logger.debug "#{inspect b64_device_sn}"
    device_sn = Base.decode64!(b64_device_sn)
    Logger.debug "device_sn:"
    Logger.debug "#{inspect device_sn}"

    Logger.debug "manufacturer_sn:"
    Logger.debug "#{inspect manufacturer_sn}"

    csr = X509.CSR.from_pem!(csr_str)

    # Name of the Signer CA certificate & Signer CA key
#    cert_name="signer-ca-2"
    app_environment = Application.get_env(@otp_app, :environment)
    cert_name = app_environment[:cert_name]
    signer_cert = File.read!("signer_certs/#{cert_name}.cert") |> X509.Certificate.from_pem!();true
    signer_key = File.read!("signer_certs/#{cert_name}.key") |> X509.PrivateKey.from_pem!();true

    device_public_key = csr |> X509.CSR.public_key()

    device_cert =
      ATECC508A.Certificate.new_device(
        device_public_key,
        device_sn,
        manufacturer_sn,
        signer_cert,
        signer_key
      )

    device_cert_pem = X509.Certificate.to_pem(device_cert)
    render(conn, "sign.json", device_cert_pem: device_cert_pem)
  end

  # --- Helper Functions

  defp check_time() do
    unless DateTime.utc_now().year >= @build_year do
      raise """
      It doesn't look like the clock has been set. Check that `nerves_time` is running
      or something else is providing time.
      """
    end
  end

  # ----- Test functions ----
  def check_env_vars() do
    Application.get_env(@otp_app, :environment)
  end
end
