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
quill.root.autofocus = true;
quill.editor.autofocus = true;

var currentBold = false;
var currentItalic = false;
var currentUnderline = false;
var currentOrdered = false;

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
                currentOrdered = false;
            } else {
                quill.format('list', 'ordered');
                currentOrdered = true;
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
            return quill.getFormat().bold;
        } else {
            return quill.getFormat(range).bold
        }
    } else {
        return uill.getFormat().bold;
    }
}

function getItalicStatus() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            return quill.getFormat().italic;
        } else {
            return quill.getFormat(range).italic
        }
    } else {
        return quill.getFormat().italic;
    }
}

function getUnderlineStatus() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            return quill.getFormat().underline;
        } else {
            return quill.getFormat(range).underline
        }
    } else {
        return quill.getFormat().italic;
    }
}

function getOrderedStatus() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            return quill.getFormat().list ? 1 : 0;
        } else {
            return quill.getFormat(range).list ? 1 : 0
        }
    } else {
        return quill.getFormat().list ? 1 : 0;
    }
}

quill.on('selection-change', function(range, oldRange, source) {
    if (range) {
        if (range.length != 0) {
            window.webkit.messageHandlers.selectionHandler.postMessage({
                'bold': quill.getFormat(range).bold ? 1 : 0,
                'italic': quill.getFormat(range).italic ? 1 : 0,
                'underline': quill.getFormat(range).underline ? 1 : 0,
                'list': quill.getFormat(range).list ? 1 : 0
            });
        }
    }
});

quill.on('text-change', function(delta, source) {
    currentBold = quill.getFormat().bold ? true : false;
    currentItalic = quill.getFormat().italic ? true : false;
    currentUnderline = quill.getFormat().underline ? true : false;
    currentOrdered = quill.getFormat().list ? true : false;
    
    window.webkit.messageHandlers.textChangeHandler.postMessage({
        'formats': quill.getFormat(),
        'bold': currentBold ? 1 : 0,
        'italic': currentItalic ? 1 : 0,
        'underline': currentUnderline ? 1 : 0,
        'list': currentOrdered ? 1 : 0
    });
});
