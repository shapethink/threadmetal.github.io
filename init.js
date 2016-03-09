(function() {
  console.log("init");

  String.prototype.strip = function() {
    return this.replace(/(^\s+)|(\s+$)/g, "");
  };

  window.onload = function() {
    var breadcrumb, breadcrumbs, breadcrumbsActivator, breadcrumbsContainer, breadcrumbsPopup, changer, footprints, header, here, i, left, len, li, link, startReview, subheader, things, top;
    changer = document.getElementById("changer");
    things = document.getElementById("things");
    if ((changer != null) && (things != null)) {
      changer.onclick = function(event) {
        things.innerHTML = "It doesn't change much yet.. but that means you're literally getting 'early access' bonus material, yay! Also, thank you :-)";
        return event.preventDefault();
      };
    }
    startReview = document.getElementById("change-manager");
    if (startReview != null) {
      startReview.onclick = function(event) {
        console.log("for now, try sending me an email :-)");
        return event.preventDefault();
      };
    }
    header = document.querySelector("h1");
    breadcrumbsActivator = header.querySelector("img");
    subheader = document.querySelector("p");
    breadcrumbsContainer = document.createElement("ul");
    breadcrumbsContainer.style.margin = "0";
    breadcrumbsContainer.style.padding = "5px";
    breadcrumbsActivator.style.cursor = "pointer";
    top = breadcrumbsActivator.y + breadcrumbsActivator.clientHeight + 5;
    left = breadcrumbsActivator.x;
    breadcrumbsPopup = document.createElement("div");
    breadcrumbsPopup.style.position = "absolute";
    breadcrumbsPopup.style.top = top + "px";
    breadcrumbsPopup.style.left = left + "px";
    breadcrumbsPopup.style.display = "none";
    breadcrumbsPopup.style.background = "white";
    breadcrumbsPopup.style.border = "1px solid black";
    breadcrumbsActivator.onclick = function() {
      if (breadcrumbsPopup.style.display === "none") {
        return breadcrumbsPopup.style.display = "block";
      } else {
        return breadcrumbsPopup.style.display = "none";
      }
    };
    breadcrumbsPopup.appendChild(breadcrumbsContainer);
    document.body.appendChild(breadcrumbsPopup);
    breadcrumbs = (function() {
      var error;
      try {
        return JSON.parse(sessionStorage.breadcrumbs);
      } catch (error) {
        return [];
      }
    })();
    here = {
      title: header.textContent.strip(),
      subtitle: subheader.textContent.strip(),
      href: window.location.href
    };
    breadcrumbs = breadcrumbs.filter(function(bc) {
      return bc.href !== here.href;
    });
    li = document.createElement("li");
    li.style["list-style-type"] = "none";
    li.appendChild(document.createTextNode("👣 you are here (" + here.title + ")"));
    breadcrumbsContainer.appendChild(li);
    for (i = 0, len = breadcrumbs.length; i < len; i++) {
      breadcrumb = breadcrumbs[i];
      li = document.createElement("li");
      li.style["list-style-type"] = "none";
      footprints = document.createTextNode("👣 ");
      link = document.createElement("a");
      link.setAttribute("href", breadcrumb.href);
      link.setAttribute("title", breadcrumb.subtitle);
      link.textContent = breadcrumb.title;
      li.appendChild(footprints);
      li.appendChild(link);
      breadcrumbsContainer.appendChild(li);
    }
    breadcrumbs.unshift(here);
    return sessionStorage.breadcrumbs = JSON.stringify(breadcrumbs);
  };

}).call(this);
