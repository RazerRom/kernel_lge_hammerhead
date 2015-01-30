#!/bin/bash

rm include/linux/uapi_random.h include/linux/random.h include/trace/events/random.h drivers/char/random.c lib/prandom_u32.c
wget -O include/linux/uapi_random.h https://raw.githubusercontent.com/torvalds/linux/master/include/uapi/linux/random.h
wget -O include/linux/random.h https://raw.githubusercontent.com/torvalds/linux/master/include/linux/random.h
wget -O include/trace/events/random.h https://raw.githubusercontent.com/torvalds/linux/master/include/trace/events/random.h
wget -O drivers/char/random.c https://raw.githubusercontent.com/torvalds/linux/master/drivers/char/random.c
wget -O lib/prandom_u32.c https://raw.githubusercontent.com/torvalds/linux/master/lib/prandom_u32.c

sed -i -e 's/uapi\/linux\/random.h/linux\/uapi_random.h/g' include/linux/random.h

sed -i 's/[[:space:]]*$//' include/linux/uapi_random.h include/linux/random.h include/trace/events/random.h drivers/char/random.c lib/prandom_u32.c

echo "--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1106,7 +1106,7 @@ static void extract_buf(struct entropy_store *r, __u8 *out)
 	__mix_pool_bytes(r, hash.w, sizeof(hash.w));
 	spin_unlock_irqrestore(&r->lock, flags);
 
-	memzero_explicit(workspace, sizeof(workspace));
+	memset(workspace, 0, sizeof(workspace));
 
 	/*
 	 * In case the hash function has some recognizable output
@@ -1118,7 +1118,7 @@ static void extract_buf(struct entropy_store *r, __u8 *out)
 	hash.w[2] ^= rol32(hash.w[2], 16);
 
 	memcpy(out, &hash, EXTRACT_SIZE);
-	memzero_explicit(&hash, sizeof(hash));
+	memset(&hash, 0, sizeof(hash));
 }
 
 /*
@@ -1175,7 +1175,7 @@ static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 	}
 
 	/* Wipe data just returned from memory */
-	memzero_explicit(tmp, sizeof(tmp));
+	memset(tmp, 0, sizeof(tmp));
 
 	return ret;
 }
@@ -1218,7 +1218,7 @@ static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
 	}
 
 	/* Wipe data just returned from memory */
-	memzero_explicit(tmp, sizeof(tmp));
+	memset(tmp, 0, sizeof(tmp));
 
 	return ret;
 }" | patch -p1

make drivers/char/random.o lib/prandom_u32.o
