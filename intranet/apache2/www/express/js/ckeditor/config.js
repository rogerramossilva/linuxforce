/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	config.language = 'pt-br';
	config.toolbar = 'Basic';
	config.forcePasteAsPlainText = true;
 
	config.toolbar_Basic =
	[
		['Bold','Italic','Strike'],
		['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
		['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
		['Link','Unlink','Anchor'],
		['Maximize']
	];
};
