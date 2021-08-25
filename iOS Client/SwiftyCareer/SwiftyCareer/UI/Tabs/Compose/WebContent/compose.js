let List = Quill.import('formats/list');

let Inline = Quill.import('blots/inline');

class BoldBlot extends Inline { }
BoldBlot.blotName = 'bold';
BoldBlot.tagName = 'strong';

class ItalicBlot extends Inline { }
ItalicBlot.blotName = 'italic';
ItalicBlot.tagName = 'em';

class UnderlineBlot extends Inline { }
UnderlineBlot.blotName = 'underline';
UnderlineBlot.tagName = 'u';

Quill.register(BoldBlot);
Quill.register(ItalicBlot);

Quill.register({
  'formats/list': List
    
});

var quill = new Quill('#postFeedEditor', {
    modules: { toolbar: [] },
    placeholder: 'What\'s on your mind?',
    theme: 'snow'
});
quill.root.setAttribute('autocomplete', 'off');
quill.root.setAttribute('autocorrect', 'off');
quill.root.setAttribute('autocapitalize', 'off');
quill.root.setAttribute('spellcheck','false');

var currentBold = false;
var currentItalic = false;
var currentUnderline = false;
var currentOrdered = null;

function formatBold() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            currentBold = !currentBold;
            quill.format('bold', currentBold);
        } else {
            if (quill.getFormat(range).bold === true) {
                quill.format('bold', false);
            } else {
                quill.format('bold', true);
            }
            currentBold = !currentBold;
        }
    }
}

function formatItalic() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            currentItalic = !currentItalic;
            quill.format('italic', currentItalic);
        } else {
            if (quill.getFormat(range).italic === true) {
                quill.format('italic', false);
            } else {
                quill.format('italic', true);
            }
            currentItalic = !currentItalic;
        }
    }
}

function formatUnderline() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            currentUnderline = !currentUnderline;
            quill.format('underline', currentUnderline);
        } else {
            if (quill.getFormat(range).italic === true) {
                quill.format('underline', false);
            } else {
                quill.format('underline', true);
            }
            currentUnderline = !currentUnderline;
        }
    }
}

function formatOrdered() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            if (currentOrdered) {
                quill.format('list', null);
                currentOrdered = null;
            } else {
                quill.format('list', 'ordered');
                currentOrdered = 'ordered';
            }
        } else {
            if (quill.getFormat(range).list === 'ordered') {
                quill.format('list', '');
            } else {
                quill.format('list', 'ordered');
            }
        }
    }
}

function getBoldStatus() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            return currentBold;
        } else {
            return quill.getFormat(range).bold
        }
    } else {
        return false;
    }
}

function getItalicStatus() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            return currentItalic;
        } else {
            return quill.getFormat(range).italic
        }
    } else {
        return false;
    }
}

function getUnderlineStatus() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            return currentUnderline;
        } else {
            return quill.getFormat(range).underline
        }
    } else {
        return false;
    }
}

quill.on('selection-change', function(range, oldRange, source) {
    if (range) {
        if (range.length != 0) {
            window.webkit.messageHandlers.selectionHandler.postMessage({
                'bold': quill.getFormat(range).bold ? 1 : 0,
                'italic': quill.getFormat(range).italic ? 1 : 0,
                'underline': quill.getFormat(range).underline ? 1 : 0
            });
        }
    }
});
