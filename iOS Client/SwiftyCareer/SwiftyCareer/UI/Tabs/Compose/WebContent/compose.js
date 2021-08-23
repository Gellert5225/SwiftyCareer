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

function formatBold() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            console.log('User cursor is at index', range.index);
            currentBold = !currentBold;
            quill.format('bold', currentBold);
        } else {
            if (quill.getFormat(range).bold === true) {
                quill.format('bold', false);
            } else {
                quill.format('bold', true);
            }
        }
    } else {
        console.log('User cursor is not in editor');
    }
}

function formatList() {
    var range = quill.getSelection();
    if (range) {
        if (range.length == 0) {
            console.log('User cursor is at index', range.index);
            currentBold = !currentBold;
            quill.format('bold', currentBold);
        } else {
            if (quill.getFormat(range).bold === true) {
                quill.format('list', false);
            } else {
                quill.format('list', 'ordered');
            }
        }
    } else {
        console.log('User cursor is not in editor');
    }
}
