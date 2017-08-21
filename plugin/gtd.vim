" Vim plugin file

if &cp || (exists('g:loaded_gtd') && g:loaded_gtd)
	finish
endif

" Init Gtd.vim configuration
if !gtd#Init()
	let g:loaded_gtd = 1
	finish
endif

" Define Gtd.vim commands

command! -bang -nargs=0 GtdNew call gtd#New(<q-mods>, <q-bang>)
command! -bang -range -nargs=0 GtdNewFromSelection <line1>,<line2>call gtd#NewFromSelection(<q-mods>, <q-bang>)
command! -bang -nargs=1 -complete=customlist,gtd#search#CommandTagComplete Gtd call gtd#search#Start(<q-bang>, <q-args>, 'new')
command! -bang -nargs=1 -complete=customlist,gtd#search#CommandTagComplete GtdAdd call gtd#search#Start(<q-bang>, <q-args>, 'add')
command! -bang -nargs=1 -complete=customlist,gtd#search#CommandTagComplete GtdFilter call gtd#search#Start(<q-bang>, <q-args>, 'filter')
command! -nargs=0 GtdRefresh call gtd#search#Start('!', gtd#quickfix#ArgsGet(), 'refresh')
command! -nargs=1 -complete=customlist,gtd#search#CommandTagComplete GtdContext call gtd#Context(<f-args>)

if !empty('g:gtd#review')
	command! -nargs=0 GtdReview call gtd#Review(<q-mods>)
endif

if g:gtd#cache == 1
	command! -nargs=0 GtdCache call gtd#cache#Refresh()
endif

if exists('g:gtd#debug') && g:gtd#debug
	command! -bang -nargs=1 -complete=customlist,gtd#search#CommandTagComplete GtdBench call gtd#Bench(<q-bang>, <q-args>)
endif

nnoremap <silent> <Plug>GtdNew :GtdNew<CR>
vnoremap <silent> <Plug>GtdNew :GtdNewFromSelection<CR>

let g:loaded_gtd = 1

