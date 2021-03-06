/*	$NetBSD: locore.S,v 1.12 2008/04/28 20:23:22 martin Exp $	*/

/*-
 * Copyright (c) 2002 The NetBSD Foundation, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#include <sh3/asm.h>

/*
 * LINTSTUB: include <sys/types.h>
 * LINTSTUB: include <dev/kloader.h>
 *
 * LINTSTUB: Var: char kernel_text[1];
 *
 * LINTSTUB: Func: void start(int argc, char *argv[], struct bootinfo *bi)
 *				__attribute__((__noreturn__))
 *	Kernel entry point. setup bootstrap stack pointer.
 *	Don't pollute r4, r5, r6, since these are passed down to
 *	machine_startup().
 */
NENTRY(start)
ALTENTRY(kernel_text)
	mov.l	.L_machine_startup, r0
	mov.l	.L_bootstrap_stack, r1
	jmp	@r0
	 mov	r1, sp
	/* NOTREACHED */

	.align	2
.L_machine_startup:	.long	_C_LABEL(machine_startup)
.L_bootstrap_stack:	.long	_C_LABEL(start)

	SET_ENTRY_SIZE(start)
