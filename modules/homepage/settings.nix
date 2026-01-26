{ ... }:
{
  services.homepage-dashboard.settings = {
    target = "_self";
    quicklaunch = {
      provider = "google";
      searchDescriptions = false;
      hideInternetSearch = false;
      showSearchSuggestions = true;
      hideVisitUrl = false;
    };
  };
}
