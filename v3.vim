let s:Observable = vital#vital#import('Rx.Observable')
let s:Operators = vital#vital#import('Rx.Operators')

function! s:subscriber(observer) abort
  call timer_start(0, { -> a:observer.next('う') })
  call timer_start(1000, { -> a:observer.next('さ') })
  call timer_start(2000, { -> a:observer.next('ぎ') })
  call timer_start(3000, { -> a:observer.next('お') })
  call timer_start(4500, { -> a:observer.next('い') })
  call timer_start(5000, { -> a:observer.next('し') })
  call timer_start(5500, { -> a:observer.next('い') })
  call timer_start(6000, { -> a:observer.next('か') })
  call timer_start(7000, { -> a:observer.next('の') })
  call timer_start(8000, { -> a:observer.next('や') })
  call timer_start(9000, { -> a:observer.next('ま') })
endfunction

function! s:start() abort
  let o = s:Observable.new(funcref('s:subscriber'))
  let o = o.pipe(s:Operators.share())
  let n = o.pipe(s:Operators.filter({ v -> v ==# 'い' }))
  let h = o.pipe(s:Operators.take_until(n))
  let t = o.pipe(
        \ s:Operators.skip_until(n),
        \ s:Operators.filter({ v -> v !=# 'い' }),
        \)
  let s = s:Observable.merge(h, t).subscribe({ v -> jobstart(['say', v])})
endfunction

call s:start()
