const Embed = Quill.import('blots/embed');

var icons = Quill.import('ui/icons');
icons['navBtn'] = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path class="ql-stroke" d="M12 6a4 4 0 1 0 4 4 4 4 0 0 0-4-4Zm0 6a2 2 0 1 1 2-2 2 2 0 0 1-2 2Z"/><path d="M12 24a5.271 5.271 0 0 1-4.311-2.2c-3.811-5.257-5.744-9.209-5.744-11.747a10.055 10.055 0 0 1 20.11 0c0 2.538-1.933 6.49-5.744 11.747A5.271 5.271 0 0 1 12 24Zm0-21.819a7.883 7.883 0 0 0-7.874 7.874c0 2.01 1.893 5.727 5.329 10.466a3.145 3.145 0 0 0 5.09 0c3.436-4.739 5.329-8.456 5.329-10.466A7.883 7.883 0 0 0 12 2.181Z"/></svg>';


class QuillNavBtn extends Embed {
  static create(val) {
    let node = super.create();
    node.setAttribute("type", "gps");

    const icon = document.createElement("svg");
    const innerIcon = document.createElement("use");
    innerIcon.setAttribute("xlink:href","img/teleport.svg#teleport");
    icon.append(innerIcon);

    node.append(icon);
    node.append(val.label);

    node.setAttribute("class", "btn btn--icon-q");
    node.setAttribute("data-label", val.label);
    node.setAttribute("data-x", val.pos.x);
    node.setAttribute("data-y", val.pos.y);
    return node;
  }

  static value(node) {
    return {
      label: node.getAttribute("data-label"),
      pos: {
        x: node.getAttribute("data-x"),
        y: node.getAttribute("data-y"),
      }
    }
  }
}

QuillNavBtn.blotName = 'navBtn'; 
QuillNavBtn.className = 'quill-nav-btn';
QuillNavBtn.tagName = 'button';

const quillNavBtnHandler = function() {
  app.resetGpsBtnData();
  app.adminData.customGpsBtn.show = true;
  app.adminData.customGpsBtn.index = this.quill.getSelection(true);
  app.adminData.customGpsBtn.quill = this.quill;
}
