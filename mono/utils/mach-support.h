#ifndef __MONO_MACH_SUPPORT_H__
#define __MONO_MACH_SUPPORT_H__

#include "config.h"
#if defined(__MACH__)
#include <glib.h>
#include <pthread.h>
#include "mono/utils/mono-compiler.h"
#include <mach/task.h>
#include <mach/mach_port.h>
#include <mach/mach_init.h>
#include <mach/thread_act.h>
#include <mach/thread_status.h>

#if defined(__i386__) || defined (__x86_64__)
#define MONO_MACH_ARCH_SUPPORTED 1
#endif

//////////////////////////////////////////////////////////////////////////
 
////!!!!vladimir begin
#if defined(IPHONEOS)
#define _STRUCT_X86_EXCEPTION_STATE32	struct __darwin_i386_exception_state
_STRUCT_X86_EXCEPTION_STATE32
{
	__uint16_t	__trapno;
	__uint16_t	__cpu;
	__uint32_t	__err;
	__uint32_t	__faultvaddr;
};

#define	_STRUCT_X86_THREAD_STATE32	struct __darwin_i386_thread_state
_STRUCT_X86_THREAD_STATE32
{
    unsigned int	__eax;
    unsigned int	__ebx;
    unsigned int	__ecx;
    unsigned int	__edx;
    unsigned int	__edi;
    unsigned int	__esi;
    unsigned int	__ebp;
    unsigned int	__esp;
    unsigned int	__ss;
    unsigned int	__eflags;
    unsigned int	__eip;
    unsigned int	__cs;
    unsigned int	__ds;
    unsigned int	__es;
    unsigned int	__fs;
    unsigned int	__gs;
};

#define _STRUCT_FP_CONTROL	struct __darwin_fp_control
_STRUCT_FP_CONTROL
{
    unsigned short		__invalid	:1,
    				__denorm	:1,
				__zdiv		:1,
				__ovrfl		:1,
				__undfl		:1,
				__precis	:1,
						:2,
				__pc		:2,
#if !defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)
#define FP_PREC_24B		0
#define	FP_PREC_53B		2
#define FP_PREC_64B		3
#endif /* !_POSIX_C_SOURCE || _DARWIN_C_SOURCE */
				__rc		:2,
#if !defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)
#define FP_RND_NEAR		0
#define FP_RND_DOWN		1
#define FP_RND_UP		2
#define FP_CHOP			3
#endif /* !_POSIX_C_SOURCE || _DARWIN_C_SOURCE */
					/*inf*/	:1,
						:3;
};
typedef _STRUCT_FP_CONTROL	__darwin_fp_control_t;

#define _STRUCT_MMST_REG	struct __darwin_mmst_reg
_STRUCT_MMST_REG
{
	char	__mmst_reg[10];
	char	__mmst_rsrv[6];
};

#define _STRUCT_XMM_REG		struct __darwin_xmm_reg
_STRUCT_XMM_REG
{
	char		__xmm_reg[16];
};

#define _STRUCT_FP_STATUS	struct __darwin_fp_status
_STRUCT_FP_STATUS
{
    unsigned short		__invalid	:1,
    				__denorm	:1,
				__zdiv		:1,
				__ovrfl		:1,
				__undfl		:1,
				__precis	:1,
				__stkflt	:1,
				__errsumm	:1,
				__c0		:1,
				__c1		:1,
				__c2		:1,
				__tos		:3,
				__c3		:1,
				__busy		:1;
};
typedef _STRUCT_FP_STATUS	__darwin_fp_status_t;

#define	_STRUCT_X86_FLOAT_STATE32	struct __darwin_i386_float_state
_STRUCT_X86_FLOAT_STATE32
{
	int 			__fpu_reserved[2];
	_STRUCT_FP_CONTROL	__fpu_fcw;		/* x87 FPU control word */
	_STRUCT_FP_STATUS	__fpu_fsw;		/* x87 FPU status word */
	__uint8_t		__fpu_ftw;		/* x87 FPU tag word */
	__uint8_t		__fpu_rsrv1;		/* reserved */ 
	__uint16_t		__fpu_fop;		/* x87 FPU Opcode */
	__uint32_t		__fpu_ip;		/* x87 FPU Instruction Pointer offset */
	__uint16_t		__fpu_cs;		/* x87 FPU Instruction Pointer Selector */
	__uint16_t		__fpu_rsrv2;		/* reserved */
	__uint32_t		__fpu_dp;		/* x87 FPU Instruction Operand(Data) Pointer offset */
	__uint16_t		__fpu_ds;		/* x87 FPU Instruction Operand(Data) Pointer Selector */
	__uint16_t		__fpu_rsrv3;		/* reserved */
	__uint32_t		__fpu_mxcsr;		/* MXCSR Register state */
	__uint32_t		__fpu_mxcsrmask;	/* MXCSR mask */
	_STRUCT_MMST_REG	__fpu_stmm0;		/* ST0/MM0   */
	_STRUCT_MMST_REG	__fpu_stmm1;		/* ST1/MM1  */
	_STRUCT_MMST_REG	__fpu_stmm2;		/* ST2/MM2  */
	_STRUCT_MMST_REG	__fpu_stmm3;		/* ST3/MM3  */
	_STRUCT_MMST_REG	__fpu_stmm4;		/* ST4/MM4  */
	_STRUCT_MMST_REG	__fpu_stmm5;		/* ST5/MM5  */
	_STRUCT_MMST_REG	__fpu_stmm6;		/* ST6/MM6  */
	_STRUCT_MMST_REG	__fpu_stmm7;		/* ST7/MM7  */
	_STRUCT_XMM_REG		__fpu_xmm0;		/* XMM 0  */
	_STRUCT_XMM_REG		__fpu_xmm1;		/* XMM 1  */
	_STRUCT_XMM_REG		__fpu_xmm2;		/* XMM 2  */
	_STRUCT_XMM_REG		__fpu_xmm3;		/* XMM 3  */
	_STRUCT_XMM_REG		__fpu_xmm4;		/* XMM 4  */
	_STRUCT_XMM_REG		__fpu_xmm5;		/* XMM 5  */
	_STRUCT_XMM_REG		__fpu_xmm6;		/* XMM 6  */
	_STRUCT_XMM_REG		__fpu_xmm7;		/* XMM 7  */
	char			__fpu_rsrv4[14*16];	/* reserved */
	int 			__fpu_reserved1;
};

#ifndef _STRUCT_MCONTEXT
#define	_STRUCT_MCONTEXT	struct __darwin_mcontext
_STRUCT_MCONTEXT32
{
	_STRUCT_X86_EXCEPTION_STATE32	__es;
	_STRUCT_X86_THREAD_STATE32	__ss;
	_STRUCT_X86_FLOAT_STATE32	__fs;
};
#endif

#ifndef _MCONTEXT_T
#define _MCONTEXT_T
typedef _STRUCT_MCONTEXT *mcontext_t;
#endif /* _MCONTEXT_T */

#endif //#if defined(IPHONEOS)
////!!!!vladimir end

//////////////////////////////////////////////////////////////////////////

// We need to define this here since we need _XOPEN_SOURCE for mono
// and the pthread header guards against this
extern pthread_t pthread_from_mach_thread_np(mach_port_t);

void *mono_mach_arch_get_ip (thread_state_t state) MONO_INTERNAL;
void *mono_mach_arch_get_sp (thread_state_t state) MONO_INTERNAL;

int mono_mach_arch_get_mcontext_size (void) MONO_INTERNAL;
void mono_mach_arch_thread_state_to_mcontext (thread_state_t state, mcontext_t context) MONO_INTERNAL;
void mono_mach_arch_mcontext_to_thread_state (mcontext_t context, thread_state_t state) MONO_INTERNAL;

int mono_mach_arch_get_thread_state_size (void) MONO_INTERNAL;
kern_return_t mono_mach_get_threads (thread_act_array_t *threads, guint32 *count) MONO_INTERNAL;
kern_return_t mono_mach_free_threads (thread_act_array_t threads, guint32 count) MONO_INTERNAL;
kern_return_t mono_mach_arch_get_thread_state (thread_port_t thread, thread_state_t state, mach_msg_type_number_t *count) MONO_INTERNAL;
kern_return_t mono_mach_arch_set_thread_state (thread_port_t thread, thread_state_t state, mach_msg_type_number_t count) MONO_INTERNAL;
void *mono_mach_arch_get_tls_value_from_thread (pthread_t thread, guint32 key) MONO_INTERNAL;

#endif
#endif /* __MONO_MACH_SUPPORT_H__ */
