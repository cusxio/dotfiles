let mapleader = ' '

nnoremap <silent> <Leader>fw :<C-u>call VSCodeNotify('workbench.action.files.save')<CR>

nnoremap <silent> <Leader>w- :<C-u>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
nnoremap <silent> <Leader>w/ :<C-u>call VSCodeNotify('workbench.action.splitEditorRight')<CR>
nnoremap <silent> <Leader>ws :<C-u>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
nnoremap <silent> <Leader>wv :<C-u>call VSCodeNotify('workbench.action.splitEditorRight')<CR>

nnoremap <silent> <Leader>wd :<C-u>call VSCodeNotify('workbench.action.closeEditorsInGroup')<CR>

nnoremap <silent> <Leader>wh :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <silent> <Leader>wH :<C-u>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
nnoremap <silent> <Leader>wj :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <silent> <Leader>wJ :<C-u>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
nnoremap <silent> <Leader>wk :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <silent> <Leader>wK :<C-u>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
nnoremap <silent> <Leader>wl :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
nnoremap <silent> <Leader>wL :<C-u>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>

nnoremap <silent> <Leader>b0 :<C-u>call VSCodeNotify('workbench.action.lastEditorInGroup')<CR>
nnoremap <silent> <Leader>b1 :<C-u>call VSCodeNotify('workbench.action.firstEditorInGroup')<CR>
nnoremap <silent> <Leader>bb :<C-u>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>
nnoremap <silent> <Leader>bd :<C-u>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <silent> <Leader>bn :<C-u>call VSCodeNotify('workbench.action.nextEditor')<CR>
nnoremap <silent> <Leader>bp :<C-u>call VSCodeNotify('workbench.action.previousEditor')<CR>
nnoremap <silent> <Leader>bu :<C-u>call VSCodeNotify('workbench.action.reopenClosedEditor')<CR>

nnoremap <silent> <Leader>/ :<C-u>call VSCodeNotify('actions.find')<CR>
nnoremap <silent> <Leader>f/ :<C-u>call VSCodeNotify('actions.find')<CR>
nnoremap <silent> <Leader>pf :<C-u>call VSCodeNotify('workbench.action.quickOpen')<CR>
