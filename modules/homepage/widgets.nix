{...}: {
  services.homepage-dashboard.widgets = [
    {
      resources = {
        cpu = true;
        memory = true;
        disk = "/";
        cputemp = true;
        uptime = true;
        units = "metric";
        refresh = 3000;
        network = true;
      };
    }
    {
      openmeteo = {
        label = "Melbourne";
        latitude = 37.8136;
        longitude = 144.9631;
        timezone = "Australia/Melbourne";
        units = "metric";
        cache = 10;
      };
    }
  ];
}
