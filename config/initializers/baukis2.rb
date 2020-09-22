Rails.application.configure do
  config.baukis2 = {
    staff: { host: "cms-example.tk", path: "" },
    admin: { host: "cms-example.tk", path: "admin" },
    customer: { host: "example.com", path: "mypage" }
  }
end
